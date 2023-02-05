# Matrix-valued shortest paths

[![Paper](https://img.shields.io/badge/Paper-arXiv-brightgreen)](https://arxiv.org/abs/2112.04165)

Code for "Shortest Paths in Graphs with Matrix-Valued Edges: Concepts, Algorithm and Application to 3D Multi-Shape Analysis", published at 3DV 2021.

![Alt text](images/teaser.png?raw=true)


## Data Preparation
Add dataset that needs to be analysed under `data/foldername`. As an example dataset we added the cats from the TOSCA dataset [1]. 
We used the shot features [2,3] and a wrapper code for Matlab that was written by Emanuele Rodola.
To obtain the code please find further instructions on their [website](http://www.vision.deis.unibo.it/research/80-shot).
We included some precomputed shot features for one example dataset. 

## Matrix-valued shortest paths
Use the `main()` function to setup the graph and to calculate the matrix-valued shortest paths. In the end the indirect paths that are shorter than the direct ones are visualized.

## References
[1]
Alexander M Bronstein, Michael M Bronstein, and Ron Kimmel. Numerical geometry of non-rigid shapes. 2008.

[2]
F. Tombari *, S. Salti *, L. Di Stefano, "Unique Signatures of Histograms for Local Surface Description", 11th European Conference on Computer Vision (ECCV), September 5-11, Hersonissos, Greece, 2010. [[PDF]](http://www.vision.deis.unibo.it/fede/papers/eccv10.pdf)

[3]
F. Tombari, S. Salti, L. Di Stefano, "A combined texture-shape descriptor for enhanced 3D feature matching", IEEE International Conference on Image Processing (ICIP), September 11-14, Brussels, Belgium, 2011. [[PDF]](http://www.vision.deis.unibo.it/fede/papers/icip11.pdf)
