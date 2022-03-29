FROM public.ecr.aws/amazonlinux/amazonlinux:2

ENV PATH=/usr/local/bin:$PATH \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    WEB_CONCURRENCY=2

# python 3.8 install
RUN yum update -y \
    && amazon-linux-extras enable python3.8 \
    && yum install -y \
           pycairo \
           python3.8 \
    && python3.8 -m pip install pip --upgrade \
    && ln -s /usr/local/bin/pip3 /usr/bin/pip3 \
    && ln -s /usr/bin/pydoc3.8 /usr/local/bin/pydoc \
    && ln -s /usr/bin/python3.8 /usr/local/bin/python \
    && ln -s /usr/bin/python3.8-config /usr/local/bin/python-config \
    && yum -y clean all --enablerepo='*' \
    && rm -rf /var/cache/yum

# add user
RUN groupadd web
RUN useradd -d /home/bottle -m bottle

WORKDIR /home/bottle
ADD . /home/bottle/

RUN pip3 install -r /home/bottle/requirements.txt

EXPOSE 8000
ENTRYPOINT ["/usr/local/bin/python", "/home/bottle/hello.py"]
USER bottle
