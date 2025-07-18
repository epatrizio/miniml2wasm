%token PLUS MINUS MUL DIV LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE COMMA SEMICOLON COLON CONS EXCL EQ LT LE GT GE EQEQ NEQ REFEQ NOT AND OR
%token LET IN BEGIN DO DONE END WHILE IF THEN ELSE REF LIST FUN IMPORT EXPORT ARROW EOF ASSERT ARRAY_SIZE ARRAY_MAKE MATRIX_MAKE LIST_HD LIST_TL LIST_EMPTY
%token TUNIT TBOOL TI32
%token <string> NAME
%token <Ast.cst> CST

%right CST
%right ASSERT

%right EQ
%right REFEQ
%right ELSE
%right IN
%right CONS
%left ARROW
%left COLON
%left REF
%left LIST
%left LIST_HD
%left LIST_TL
%left LIST_EMPTY

%right OR
%right AND
%left LT GT LE GE NEQ EQEQ
%left PLUS MINUS
%left MUL DIV

%nonassoc unary_op (* unary operators - administrative pseudo-token to distinguish unary minus from subtraction *)
%nonassoc LBRACKET

%{

open Ast

%}

%start prog

%type <Ast.prog> prog

%%

let prog :=
  | ~ = block; EOF; <>

let stmt_bis :=
  | LET; ~ = ident; EQ; ~ = expr; <Slet>
  | i = ident; REFEQ; e = expr; { Sassign (Vident i, e) }
  | var = var; e1 = delimited(LBRACKET, expr, RBRACKET); REFEQ; e2 = expr; {
    match var with
    | Vident _ident as vi -> Sassign (Varray (vi, e1), e2)
    | Varray (Vident _ident, _e) as va -> Sassign (Varray (va, e1), e2)
    | _ -> assert false (* only 1-dim & 2-dim array are supported *)
  }
  | WHILE; ~ = expr; DO; ~ = block; DONE; <Swhile>
  | ASSERT; ~ = expr; <Sassert>

let stmt :=
  | ~ = stmt_bis; { (($startpos, $endpos), (stmt_bis : stmt')) : stmt }

let block :=
  | ~ = expr; <Bexpr>
  | ~ = expr; SEMICOLON; ~ = block; <Bseq>

let var :=
  | ~ = ident; <Vident>
  | ~ = var; ~ = delimited(LBRACKET, expr, RBRACKET); <Varray>

let expr_bis :=
  | LPAREN; RPAREN; { Ecst Cunit }
  | ~ = CST; <Ecst>
  | ~ = var; <Evar>
  | ~ = unop; ~ = expr; %prec unary_op <Eunop>
  | e1 = expr; ~ = binop; e2 = expr; <Ebinop>
  | BEGIN; ~ = block; END; <Eblock>
  | IF; ~ = expr; THEN; e1 = expr; ELSE; e2 = expr; <Eif>
  | LET; ~ = ident; EQ; e1 = expr; IN; e2 = expr; <Elet>
  | ~ = preceded(REF, expr); <Eref>
  | EXCL; ~ = ident; <Ederef>
  | e1 = expr; CONS; e2 = expr; <Econs>
  | ~ = delimited(LBRACKET, separated_list(COMMA, expr), RBRACKET); <Earray_init>
  | ARRAY_SIZE; ~ = var; <Earray_size>
  | ARRAY_MAKE; ~ = CST; ~ = expr; <Earray_make>
  | MATRIX_MAKE; ~ = CST; ~ = CST; ~ = expr; <Earray_matrix_make>
  | LIST_HD; ~ = expr; <Elist_hd>
  | LIST_TL; ~ = expr; <Elist_tl>
  | LIST_EMPTY; ~ = expr; <Elist_empty>
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
  | name = NAME; typ = preceded(COLON, typ); { (typ, name) : ident }
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
  | ~ = terminated(typ, LIST); <Tlist>
  | typ = typ; cst = delimited(LBRACKET, CST, RBRACKET); {
      match cst with
      | Ci32 i32 -> Tarray (typ, i32)
      | _ -> assert false }
  | args_typ = typ; ARROW; return_typ = typ; {
      match return_typ with
      | Tunit | Tbool | Ti32 | Tlist _ | Tarray _ ->
        begin match args_typ with
          | Tunit -> Tfun ([], return_typ)
          | Tbool | Ti32 | Tlist _ | Tarray _ -> Tfun ([ args_typ ], return_typ)
          | Tfun (args_t, ret_t) -> Tfun (args_t @ [ ret_t ], return_typ)
          | _ -> assert false
        end
      | _ -> assert false
  }

%%
