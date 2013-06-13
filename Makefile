OCAMLC=ocamlc
OCAMLOPT=ocamlopt

INCLUDES=-I /usr/local/lib/ocaml -I src/
CCFLAGS=-cclib -lstdc++

LLVMCMAPATH=/usr/local/lib/ocaml
LLVMCMAS=$(LLVMCMAPATH)/llvm.cma $(LLVMCMAPATH)/llvm_analysis.cma
LLVMCMXS=$(LLVMCMAPATH)/llvm.cmxa $(LLVMCMAPATH)/llvm_analysis.cmxa
COMPFLAGS=-g $(CCFLAGS) $(INCLUDES) -pp camlp4oof $(LLVMCMAS)
OPTFLAGS=-g $(CCFLAGS) $(INCLUDES) -pp camlp4oof $(LLVMCMXS)

SRCS=src/token.ml src/lexer.ml src/ast.ml src/parser.ml src/codegen.ml src/toplevel.ml src/toy.ml
OBJS=src/token.cmo src/lexer.cmo src/ast.cmo src/parser.cmo src/codegen.cmo src/toplevel.cmo src/toy.cmo
NOBJS=src/token.cmx src/lexer.cmx src/ast.cmx src/parser.cmx src/codegen.cmx src/toplevel.cmx src/toy.cmx

%.cmo: %.ml
	$(OCAMLC) $(COMPFLAGS) $< -c -o $@

%.cmi: %.mli
	$(OCAMLC) $(COMPFLAGS) $< -c -o $@

%.cmx: %.ml
	$(OCAMLOPT) $(OPTFLAGS) $< -c -o $@

build: $(OBJS)
	$(OCAMLC) $(COMPFLAGS) $^ -o toy

native: $(NOBJS)
	$(OCAMLOPT) $(OPTFLAGS) $^ -o toy

clean:
	-rm src/*.cmo src/*.cmi src/*.cmx src/*.o toy
