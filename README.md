# ISC_Final
For my final project, I made a series of functions that would be able to turn a newick file into a MrBayes backbone constraint.
MrBayes cannot read a newick tree file as a constraint, and can only read them in as starting trees.
Therefore, I wanted to make a function that could produce a constraint usable in MrBayes

test_tree.txt contains a simple newick tree to demonstrate that the code works

The topology of the tree is:

( (A, B) , ( (C, D) , E ));

What the function should returned is: 

constraint backbone1 partial = A B : C D E;

constraint backbone2 partial = C D E : A B;

constraint backbone3 partial = C D : A B E;

prset topologypr = constraints( backbone1, backbone2, backbone3);

A general way of how MrBayes reads these constraints:

constraint [name of constraint] partial = [monophyletic group] : [Everything you know that is not in the monphyletic group];

^this loads the constraints into MrBayes

prset topologypr = constraints ( [name of constraint], [name of constraint], [etc] );

^this tells MrBayes to use whatever you loaded as a constraint


MrBayes is able to read the above text and interpret it as a backbone constraint tree
It will therefore constraint the tree search and force it to return the given topology

Code:

In the code folder is my Rscript

The following packages are used in the function:

>library(ape)
>library(geiger)
>library(phytools)
>library(tools)

Installing them is not in the function, therefore, if the packages are not installed on the computer, they need to be for the code to run.

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

In this folder are two sample constraint trees in newick format and one test tree. 
They were derived from the paper Arnason, Ulfur, et al. "Pinniped phylogeny and a new hypothesis for their origin and dispersal." Molecular phylogenetics and evolution 41.2 (2006): 345-354.
