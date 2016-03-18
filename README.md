# ISC_Final
For my final project, I made a series of functions that would be able to turn a newick file into a MrBayes backbone constraint.
MrBayes cannot read a newick tree file as a constraint, and can only read them in as starting trees.
Therefore, I wanted to make a function that could produce a constraint usable in MrBayes

Code:
In the code folder is my Rscript

These files can be called using the command line in terminal
> Rscript Final_Proj.R ../Data

Two functions in the file
Make_MrBayes_Constraint:
Turns a newick file into a MrBayes backbone constraint 
The input is a .txt file in standard newick format, ex: ((a,b),c);
The output is a .txt file with the same name with '.output.txt' appended to it
If you run the script again, it will make append to the existing file with the '.output.txt' ending

Constraint_All_in_Dir:
Applies Make_MrBayes_Constraint to all files in a directory
All of the files need to be .txt files in standard newick format

Data:
In this folder are two sample constraint trees in newick format. 
They were derived from the paper Arnason, Ulfur, et al. "Pinniped phylogeny and a new hypothesis for their origin and dispersal." Molecular phylogenetics and evolution 41.2 (2006): 345-354.
