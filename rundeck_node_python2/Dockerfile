From ietty/base-python

MAINTAINER takemi.ohama<takemi.ohama@gmail.com>

RUN conda install -c trent --quiet --yes  python=2.7 lshash

RUN conda install --quiet --yes python=2.7 \
    'conda-build' \
    'readline' \
    'pandas' \
    'numexpr' \
    'scipy' \
    'scikit-learn' \
    'scikit-image' \
    'sympy=1.0*' \
    'cython=0.25*' \
    'patsy=0.4*' \
    'statsmodels' \
    'cloudpickle' \
    'dill' \
    'numba' \
    'bokeh' \
    'hdf5' \
    'h5py' \
    'mysql-connector-python' \
    'pymysql' \
    'sqlalchemy' \
    'gensim' \
    'vincent' \
    'beautifulsoup4' \
    'pyzmq' \
    'xlrd' \ 
    && conda clean -tipsy

RUN rm -f $CONDA_DIR/bin/pip && ln -s $CONDA_DIR/envs/python2/bin/pip $CONDA_DIR/bin/pip

CMD ["/usr/sbin/sshd", "-D"]
