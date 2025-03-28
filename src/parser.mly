%token PLUS MINUS MUL DIV LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON COLON EXCL EQ LT LE GT GE EQEQ NEQ REFEQ NOT AND OR
%token LET IN BEGIN DO DONE END WHILE IF THEN ELSE REF FUN IMPORT EXPORT ARROW EOF ASSERT ARRAY_SIZE
%token TUNIT TBOOL TI32
%token <string> NAME
%token <Ast.cst> CST

// %token UNARY_OP (* administrative token to distinguish unary minus from subtraction *)

%nonassoc ASSERT

%right OR
%right AND
%left LT GT LE GE NEQ EQEQ
%left PLUS MINUS
%left MUL DIV

%nonassoc UNARY_OP (* unary operators *)
%nonassoc ELSE
%nonassoc IN

%{

open Ast

%}

%start prog

%type <Ast.prog> prog
// %type <Ast.expr'> expr_bis
// %type <Ast.stmt'> stmt_bis
// %type <Ast.ident> ident

%%

let prog :=
  | ~ = block; EOF; <>

let stmt_bis :=
  | LET; ~ = ident; EQ; ~ = expr; <Slet>
  | ~ = ident; REFEQ; ~ = expr; <Srefassign>
  | ~ = ident; LBRACKET; e1 = expr; RBRACKET; REFEQ; e2 = expr; <Sarrayassign>
  | WHILE; ~ = expr; DO; ~ = block; DONE; <Swhile>
  | ASSERT; ~ = expr; <Sassert>

let stmt :=
  | ~ = stmt_bis; { (($startpos, $endpos), (stmt_bis : stmt')) : stmt }

let block :=
  | ~ = expr; <Bexpr>
  | ~ = expr; SEMICOLON; ~ = block; <Bseq>

let var :=
  | ~ = ident; <Vident>
  | ~ = ident; LBRACKET; ~ = expr; RBRACKET; <Varray>

let expr_bis :=
  | ~ = CST; <Ecst>
  | ~ = var; <Evar>
  | ~ = unop; ~ = expr; %prec UNARY_OP <Eunop>
  | e1 = expr; ~ = binop; e2 = expr; <Ebinop>
  | BEGIN; ~ = block; END; <Eblock>
  | IF; ~ = expr; THEN; e1 = expr; ELSE; e2 = expr; <Eif>
  | LET; ~ = ident; EQ; e1 = expr; IN; e2 = expr; <Elet>
  | ~ = preceded(REF, expr); <Eref>
  | EXCL; ~ = ident; <Ederef>
  | LBRACKET; ~ = separated_nonempty_list(COMMA, expr); RBRACKET; <Earray_init>
  | ~ = var; LBRACKET; ~ = expr; RBRACKET; <Earray>
  | ARRAY_SIZE; ~ = ident; <Earray_size>
  | export = option(EXPORT); FUN; idents = delimited(LPAREN, separated_list(COMMA, ident), RPAREN); typ = option(preceded(COLON, typ)); body = delimited(LBRACE, block, RBRACE); {
      match typ with
      | Some typ -> Efun_init (Option.is_some export, idents, typ, body)
      | None -> Efun_init (Option.is_some export, idents, Tunknown, body) }
  | IMPORT; FUN; typs = delimited(LPAREN, separated_list(COMMA, typ), RPAREN); typ = preceded(COLON, typ); {
      Efun_import_init (Tfun (typs, typ)) }
  | ~ = ident; ~ = delimited(LPAREN, separated_list(COMMA, expr), RPAREN); <Efun_call>
  | ~ = stmt; <Estmt>

let expr :=
  | ~ = expr_bis; { (($startpos, $endpos), Tunknown, (expr_bis : expr')) : expr }
  | expr = delimited(LPAREN, expr, RPAREN); { expr }

let ident :=
  | name = NAME; COLON; typ = typ; { (typ, name) : ident }
  | name = NAME; { (Tunknown, name) : ident }

%inline binop :
  | AND; { Band }
  | OR; { Bor }
  | PLUS; { Badd }
  | MINUS; { Bsub }
  | MUL; { Bmul }
  | DIV; { Bdiv }
  | LT; { Blt }
  | LE; { Ble }
  | GT; { Bgt }
  | GE; { Bge }
  | EQEQ; { Beq }
  | NEQ; { Bneq }

let unop :=
  | NOT; { Unot }
  | MINUS; { Uminus }

let typ :=
  | TUNIT; { Tunit }
  | TBOOL; { Tbool }
  | TI32; { Ti32 }
  | ~ = terminated(typ, REF); <Tref>
  | typ = typ; cst = delimited(LBRACKET, CST, RBRACKET); {
      match cst with
      | Ci32 i32 -> Tarray (typ, i32)
      | _ -> assert false }
  | args_typ = typ; ARROW; return_typ = typ; {
      match args_typ with
      | Tunit -> Tfun ([], return_typ)
      | Tbool | Ti32 | Tarray _ -> Tfun ([ args_typ ], return_typ)
      | Tfun (args_t, ret_t) -> Tfun (args_t @ [ ret_t ], return_typ)
      | _ -> assert false
  }

%%
