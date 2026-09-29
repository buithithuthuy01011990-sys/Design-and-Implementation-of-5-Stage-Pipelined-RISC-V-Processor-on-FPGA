
# Define variables
TESTNAME       ?= default_value_test
TB_NAME        ?= tb_riscv_uart_soc
RADIX          ?= hexadecimal
REGRESS_LIST   ?= regress.list
SRCLIST_V_T    ?= compile

# macro_en     ?= +define+write_enable
macro_en       ?=



.PHONY: all build run find create_test_list regress regress_cov wave run_cov gen_cov clean report

all: build run

regression: build create_test_list regress report

regression_cov: build create_test_list regress_cov gen_cov


build:
	mkdir -p log
	touch run_test.vt
	vlib.exe work
	vmap.exe work work
	vlog.exe -coveropt 3 +cover +acc -f $(SRCLIST_V_T).f


run:
#	cp -rf tb/$(TESTNAME).vt run_test.vt
	vlog.exe $(macro_en) -f compile.f
	vsim.exe -l $(TESTNAME).log -voptargs=+acc -assertdebug -c $(TB_NAME) -do "log -r /*; run -all; quit;"
	mv $(TESTNAME).log ./log
	cp -rf vsim.wlf $(TESTNAME).wlf
	mv $(TESTNAME).wlf ./log
	ln -sf ./log/$(TESTNAME).log sim.log



find:
	find tb

create_test_list:
	find tb -type f -name "*.vt" -printf "%f\n" | sed 's/\.vt$$//' | tee $(REGRESS_LIST) | wc -l



regress:

	./run_all.sh run




regress_cov:

	./run_all.sh run_cov



wave:
	vsim.exe -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -s $(RADIX)"



run_cov:
	cp -rf tb/$(TESTNAME).vt run_test.vt
	vlog.exe +cover=sbecfsx -f compile.f
	vsim.exe -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover=sbecfsx" -novopt -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r -d 6 /*; run -all"
	mv $(TESTNAME).log ./log



gen_cov:
	mkdir -p coverage
	vcover.exe merge IP.ucdb *.ucdb
	vcover.exe report IP.ucdb -file coverage/summary_report.txt
	vcover.exe report -zeros -details -code bcefsx -All -codeAll IP.ucdb -file coverage/detail_report.txt



clean:
	rm -rf work
	rm -rf log
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf transcript
	rm -rf coverage
	rm -rf *.ucdb
	rm -rf *.list
	rm -rf *.vt



report:
	grep "passed" ./log/*.log -R