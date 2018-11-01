#!/usr/bin/env python

import os
import re
import sys
import tempfile

from .download import TUFDownloader


def wheel_name(distribution):
    # https://www.python.org/dev/peps/pep-0491/#escaping-and-unicode
    return re.sub("[^\w\d.]+", "_", distribution, re.UNICODE)


def main():
    distribution, version = sys.argv[1].split('==', 1)
    wheel = wheel_name(distribution)
    dest_dir = tempfile.gettempdir()

    here = os.path.abspath(os.path.dirname(__file__))
    config = os.path.join(here, 'integrations-core-downloader.json')
    tuf_downloader = TUFDownloader(config)
    target_relpath = 'simple/{}/{}-{}-py2.py3-none-any.whl'\
                     .format(distribution, wheel, version)
    tuf_downloader.download(target_relpath, dest_dir)
