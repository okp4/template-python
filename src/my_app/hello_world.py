import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.INFO)


def say_hi(name: str):
    logging.info("Hello World! Welcome " + name)
