MODULES = 
CMODULES = $(pathsubst %.sv .%.compiled, $(MODULES))
CURRENT_TB = 

sim : compile | work

	vsim $(CURRENT_TB)

work :
	vlib work

compile : $(CMODULES)

.%.compile : %.sv
	vlog +acc $< && touch $@

clean :
	rm -f $(CMODULES)
	rm -f *~
	rm -f ../src/*.sv~
	rm -r -f work