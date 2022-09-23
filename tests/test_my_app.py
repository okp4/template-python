from my_app import __version__


def test_version_displays_library_version():
    assert __version__ == "0.1.0", "Version number should match library version."
