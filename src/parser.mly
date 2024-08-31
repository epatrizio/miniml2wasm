%token PLUS MINUS MUL DIV SEMICOLON EQ LT LE GT GE EQEQ NEQ NOT AND OR
%token LET IN BEGIN DO DONE END WHILE IF THEN ELSE EOF PRINT
// %token TUNIT TBOOL TI32 COLON LPAREN RPAREN
%token <string> IDENT
%token <Ast.cst> CST

// %left OR
// %left AND
// %left LT GT LE GE NEQ EQEQ
// %left PLUS MINUS
// %left MUL DIV FLDIV MOD

%{

open Ast

%}

%start prog

%type <Ast.prog> prog
%type <Ast.expr'> expr_bis
%type <Ast.stmt'> stmt_bis

%%

let prog :=
  | ~ = stmt; EOF; <>

let stmt_bis :=
  | LET; ~ = IDENT; EQ; ~ = expr; IN; ~ = stmt; <Sassign>   // TODO add static type (with () ?)
  | BEGIN; ~ = block; END; <Sblock>
  | IF; ~ = expr; THEN; s1 = stmt; ELSE; s2 = stmt; <Sif>
  | WHILE; ~ = expr; DO; ~ = block; DONE; <Swhile>
  | PRINT; ~ = expr; <Sprint>

let stmt :=
  | ~ = stmt_bis; { (($startpos, $endpos), (stmt_bis : stmt')) : stmt }

let block :=
  | ~ = stmt; <Bstmt>
  | ~ = stmt; SEMICOLON; ~ = block; <Bseq>

let expr_bis :=
  | ~ = CST; <Ecst>
  | ~ = IDENT; <Eident>
  | ~ = unop; ~ = expr; <Eunop>
  | ~ = binop; e1 = expr; e2 = expr; <Ebinop>
  
let expr :=
  | ~ = expr_bis; { (($startpos, $endpos), Tunknown, (expr_bis : expr')) : expr }

let binop :=
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

%%
