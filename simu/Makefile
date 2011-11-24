MODULES = duplicated_carry_select_adder_64b.sv basis_adder.sv fra-basic-bl-a.sv fra-basic-bl-b.sv sdb-inner.sv sdb.sv
CMODULES = $(patsubst %.sv,.%.compiled,$(MODULES) $(CURRENT_TB.sv))
CURRENT_TB.sv = basic_adder_tb.sv
CURRENT_TB = $(patsubst %.sv,%,$(CURRENT_TB.sv))

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