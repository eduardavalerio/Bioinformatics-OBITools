conda create -n obitools-env python=2.7
conda activate obitools-env

conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority strict

conda install -c bioconda obitools
conda list obitools

find $CONDA_PREFIX -name "obitools"
$CONDA_PREFIX/bin/obitools
nano ~/.zshrc

#Add the following line to the file
export PATH=$CONDA_PREFIX/bin:$PATH
#Save the file and reload the shell configuration

source ~/.zshrc #See if the obitools-env is in your PATH

ngsfilter --help
#If this displays the help message, you’re ready to start using OBITools.
