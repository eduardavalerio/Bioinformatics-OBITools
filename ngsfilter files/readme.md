## NGSfilter file 🧬

The NGSfilter file is a text file that provides sample descriptions, including sample names, positions on a plate,
primer sequences, and tag sequences, used for demultiplexing and further processing of next-generation sequencing (NGS) data. 

The files were organized in this order:

| Library code | Sample code | Tags | Forward | Reverse | Plate position |
| ------------ | ----------- | ---- | ------- | ------- | -------------- |

The files were named as **ngsfilter_libX_pontos - ptX(s/w)(s/d).tsv**

- Lib1 - Alcatrazes Archipelago
- Lib2 - Queimada Grande Island 
- Lib3 - Laje de Santos Marine State Park
- Lib4 - Búzios Island

The OBITools pipeline accept the ngsfilte on a txt or tsv file.

For more informations access [Ubuntu Manuals](https://manpages.ubuntu.com/manpages/focal/man1/ngsfilter.1.html).
