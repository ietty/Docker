From ietty/base-python

MAINTAINER "takemi.ohama" <takemi.ohama@ietty.co.jp>

# Install Python 3 packages
RUN conda install --quiet --yes \
    'pytz' \
    'pandas' \
    'numexpr' \
    'cython' \
    'mysql-connector-python' \
    'pymysql' \
    'sqlalchemy' \
    'boto3' \
    'sagemaker-python-sdk' \
    'joblib' \
    'aiobotocore' \
    'nest-asyncio' \
    && conda clean -tipsy

ENTRYPOINT ["tail","-f","/dev/null"]

#USER docker
