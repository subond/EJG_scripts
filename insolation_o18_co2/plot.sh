#! /bin/bash

fortran_compiler=gfortran

${fortran_compiler} -o misbox misbox.f90

# text options for the region name
size="12p"
fontname="Helvetica-Bold"
color="black"
justification="+cBL" # the +c option plots relative to the corners of the map
#justification="+jBR" # alternatively, plots relative to the location given in the text file
text_angle="+a0"
text_options="-F+f${size},${fontname},${color} -F${justification} -F${text_angle} "



plot=climate_parameters.ps

# tc plot

xmin=0
xmax=800

width="24c"
height="5.5c"



# LR04
ymin=2.5
ymax=5.5

J_options="-JX-${width}/-${height}"

R_options="-R${xmin}/${xmax}/${ymin}/${ymax}"



./misbox ${ymin} ${ymax}

gmt psxy  warm_mis.txt   -L -Glightred ${J_options} ${R_options}  -K  > ${plot}
gmt psxy  cold_mis.txt   -L -Glightskyblue ${J_options} ${R_options}  -K -O >> ${plot}

gmt psxy lr04.txt  -BWSen -Bxa100f20+l"Age (kyr BP)" -Bya1f0.5+l"benthic @%12%\144@%%@+18@+O"    ${J_options} ${R_options} -K -O -Wthick,black  >> ${plot}

gmt pstext mis_text.txt  ${J_options} ${R_options}  -Gwhite -O -K -F+f8p,Helvetica,black+jcm >> ${plot}

gmt pstext << END_TEXT -K -O -J -R ${text_options} -P -Gwhite -D0.1/0.25 -N >> ${plot}
LR04 benthic stack (Lisiecki and Raymo, 2004)
END_TEXT

# CO2
ymin=150
ymax=300

J_options="-JX-${width}/${height}"

R_options="-R${xmin}/${xmax}/${ymin}/${ymax}"


./misbox ${ymin} ${ymax}

gmt psxy  warm_mis.txt  -Y${height} -L -Glightred ${J_options} ${R_options}  -K  -O >> ${plot}
gmt psxy  cold_mis.txt   -L -Glightskyblue ${J_options} ${R_options}  -K -O >> ${plot}

gmt psxy antarctica_CO2.txt   -BWsen  -Bya40f20+l"CO@-2@- (PPM)"    ${J_options} ${R_options} -K -O -Wthick,black  >> ${plot}

gmt pstext << END_TEXT -K -O -J -R ${text_options} -P -Gwhite -D0.1/0.25 -N >> ${plot}
Antarctica CO@-2@- (Bereiter et al., 2015)
END_TEXT

# Insolation
ymin=410
ymax=560

J_options="-JX-${width}/${height}"

R_options="-R${xmin}/${xmax}/${ymin}/${ymax}"

./misbox ${ymin} ${ymax}

gmt psxy  warm_mis.txt   -Y${height}  -L -Glightred ${J_options} ${R_options}  -K  -O >> ${plot}
gmt psxy  cold_mis.txt   -L -Glightskyblue ${J_options} ${R_options}  -K -O >> ${plot}


gmt pstext << END_TEXT -K -O -J -R ${text_options} -P -Gwhite -D0.1/0.25 -N >> ${plot}
Summer Insolation 60\260N
END_TEXT

gmt psxy Daily_insolation60.txt -BWsen  -Bya20f10+l"Insolation 60\260N (W/m@+2@+)"    ${J_options} ${R_options}  -O -Wthick,black  >> ${plot}

gmt psconvert -Tf -A *.ps
gmt psconvert -Tg -A *.ps


