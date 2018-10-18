From ietty/base-python

MAINTAINER "takemi.ohama" <takemi.ohama@ietty.co.jp>

# Install Python 3 packages
RUN conda install --quiet --yes \
    'conda-build' \
    'conda-env' \
    'readline' \
    'pytz' \
    'pandas' \
    'numexpr' \
    'scipy' \
    'seaborn' \
    'scikit-learn' \
    'scikit-image' \
    'sympy' \
    'cython' \
    'patsy' \
    'statsmodels' \
    'cloudpickle' \
    'dill' \
    'numba' \
    'bokeh' \
    'h5py' \
    'mysql-connector-python' \
    'pymysql' \
    'sqlalchemy' \
    'gensim' \
    'chainer' \
    'falcon' \
    'gunicorn' \
    'newrelic' \
    && conda clean -tipsy

RUN pip install -U numpy && pip install chainercv

ENTRYPOINT ["tail","-f","/dev/null"]

#USER docker
