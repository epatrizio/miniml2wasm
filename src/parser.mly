%token PLUS MINUS MUL DIV LPAREN RPAREN SEMICOLON COLON EQ LT LE GT GE EQEQ NEQ NOT AND OR
%token LET IN BEGIN DO DONE END WHILE IF THEN ELSE EOF PRINT
%token TUNIT TBOOL TI32
%token <string> NAME
%token <Ast.cst> CST

// %token UNARY_OP (* administrative token to distinguish unary minus from subtraction *)

(* tmp (PRINT token), coming soon: it should be a func app *)
%nonassoc PRINT

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
  | WHILE; ~ = expr; DO; ~ = block; DONE; <Swhile>
  | PRINT; ~ = expr; <Sprint>

let stmt :=
  | ~ = stmt_bis; { (($startpos, $endpos), (stmt_bis : stmt')) : stmt }

let block :=
  | ~ = expr; <Bexpr>
  | ~ = expr; SEMICOLON; ~ = block; <Bseq>

let expr_bis :=
  | ~ = CST; <Ecst>
  | ~ = ident; <Eident>
  | ~ = unop; ~ = expr; %prec UNARY_OP <Eunop>
  | e1 = expr; ~ = binop; e2 = expr; <Ebinop>
  | BEGIN; ~ = block; END; <Eblock>
  | IF; ~ = expr; THEN; e1 = expr; ELSE; e2 = expr; <Eif>
  | LET; ~ = ident; EQ; e1 = expr; IN; e2 = expr; <Elet>
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

%%
