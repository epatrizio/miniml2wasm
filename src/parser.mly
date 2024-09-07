%token PLUS MINUS MUL DIV SEMICOLON COLON EQ LT LE GT GE EQEQ NEQ NOT AND OR
%token LET IN BEGIN DO DONE END WHILE IF THEN ELSE EOF PRINT
%token TUNIT TBOOL TI32
%token <string> NAME
%token <Ast.cst> CST

// %token UNARY_OP (* administrative token to distinguish unary minus from subtraction *)

%left OR
%left AND
%left LT GT LE GE NEQ EQEQ
%left PLUS MINUS
%left MUL DIV
%nonassoc UNARY_OP (* unary operators *)

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
  | ~ = stmt; EOF; <>

let stmt_bis :=
  | LET; ~ = ident; EQ; ~ = expr; IN; ~ = stmt; <Sassign>
  | BEGIN; ~ = block; END; <Sblock>
  | IF; ~ = expr; THEN; s1 = stmt; ELSE; s2 = stmt; <Sif>
  | WHILE; ~ = expr; DO; ~ = block; DONE; <Swhile>
  | PRINT; ~ = expr; <Sprint>

let stmt :=
  | ~ = stmt_bis; { (($startpos, $endpos), Tunknown, (stmt_bis : stmt')) : stmt }

let block :=
  | ~ = stmt; <Bstmt>
  | ~ = stmt; SEMICOLON; ~ = block; <Bseq>

let expr_bis :=
  | ~ = CST; <Ecst>
  | ~ = ident; <Eident>
  | ~ = unop; ~ = expr; %prec UNARY_OP <Eunop>
  | e1 = expr; ~ = binop; e2 = expr; <Ebinop>

let expr :=
  | ~ = expr_bis; { (($startpos, $endpos), Tunknown, (expr_bis : expr')) : expr }

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

let typ :=
  | TUNIT; { Tunit }
  | TBOOL; { Tbool }
  | TI32; { Ti32 }

%%
