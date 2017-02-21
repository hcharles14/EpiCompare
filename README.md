# EpiCompare
README file is created by Yu He on 02/21/2017.Please contact yu.he@wustl.edu with questions or for clarifications.

This file is part of EpiCompare. EpiCompare is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.


#Availability
EpiCompare is a web server. The web server is availabe at http://epigenome.wustl.edu/EpiCompare/. The source code is available at https://github.com/hcharles14/EpiCompare. 

#Launch EpiCompare
EpiCompare is hosted under free Shiny server (verssion ). To launch EpiCompare, after installing Shiny server, create the app with given codes and provide the data files (Rdata,coordinates, H3K27ac_peak_sort, which are examples right now). You also need to make the write_to_disk folder under www folder publicly accessible because EpiCompare will write and read data files in write_to_disk folder. 

