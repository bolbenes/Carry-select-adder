MODULES = fra-basic-bl-a.sv fra-basic-bl-b.sv sdb-inner.sv sdb.sv
CMODULES = $(patsubst %.sv,.%.compiled,$(MODULES)$(CURRENT_TB))
CURRENT_TB = SDB_inner_tb.sv

VPATH = ../src 

sim : compile

	vsim $(CURRENT_TB)

work :
	vlib work

compile : $(CMODULES)

.%.compiled : %.sv | work
	vlog +acc $< && touch $@

clean :
	rm -f $(CMODULES)
	rm -f *~
	rm -f ../src/*.sv~
	rm -r -f work