import click

from my_app import __init__ as init
from my_app.hello_world import say_hi


cli = click.Group()


@cli.command("version")
def print_version():
    """Print the application version information"""
    click.echo(init.__version__)


@cli.command("main_cmd")
@click.option(
    "-n",
    "--name",
    "name",
    type=str,
    required=False,
    default="friend",
    help="A name to salute",
)
def main_cmd(name: str):
    """Does something interesting..."""
    say_hi(name)


if __name__ == "__main__":
    cli()
