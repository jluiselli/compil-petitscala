(******************************************************************************
 * Project: pscala
 * By: Théophile Bastian <contact@tobast.fr>
 *
 * This project implements a compiler for "Petit Scala", as defined in
 * <https://www.lri.fr/~filliatr/ens/compil/projet/sujet1-v1.pdf>
 * It is developped as a school project for J-C. Filliâtre's Compilation course
 * at the Ecole Normale Superieure, Paris.
 ******************************************************************************
 * File: typedefs.ml
 *
 * Declares types that will be useful all around in the code
 *****************************************************************************)

type varType = Ast.access * bool * Ast.typ (* ident * mutable? * type *)

type typingEnvironment = {
	suptypeDecl : (Ast.typ list) Ast.SMap.t ;
	classes : Ast.classDef Ast.SMap.t ;
	vars : varType list
}
