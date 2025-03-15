# How to install OBITools on Mac

### Prerequisites
1. Miniconda [Install Miniconda](https://www.anaconda.com/docs/getting-started/miniconda/install#macos-linux-installation)

### On MAC terminal 
1. **Create and activate a conda environment with python 2.7** (OBItools just run in Python version 2.7)

`conda create -n obitools-env python=2.7`

`conda activate obitools-env`

2. **Add bioconda and conda-forge channels and set as priority**

`conda config --add channels bioconda`

`conda config --add channels conda-forge`  

`conda config --set channel_priority strict`

3. **Install and verify obitools in this environment**

`conda install -c bioconda obitools`

`conda list obitools`

You should see something like this:

<img src="https://github.com/user-attachments/assets/c7653c27-e06a-489a-8983-4747c6611d6d" width="50%" />


If obitools is listed, it means the package is installed.

Try to execute the command: `ngsfilter --help`

If the command is not found, it might not be in your PATH.

4. **Add OBITools in your PATH**

`find $CONDA_PREFIX -name "obitools"`

`$CONDA_PREFIX/bin/obitools`

`nano ~/.zshrc`

Add the following line to the file: `export PATH=$CONDA_PREFIX/bin:$PATH`

Save the file and reload the shell configuration

`source ~/.zshrc`

See if the obitools-env is in your PATH 

5. **Verify if it's all working**

`ngsfilter --help`

If this displays the help message, you’re ready to start using OBITools.
<img src="https://github.com/user-attachments/assets/4dc63c52-11e8-422d-9651-ed21da6083a7" width="50%" />


