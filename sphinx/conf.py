# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

import matplotlib

project = 'bulletchess'
copyright = '2025, Jordan Zedeck. Licensed under GPL v3.'
author = 'Jordan Zedeeck'
# release = '0.2.0'

extensions = [
        'sphinx.ext.autodoc',
        'sphinx_gallery.gen_gallery',
        'autoapi.extension',
        'sphinx_markdown_builder'
]

sphinx_gallery_conf = {
     'examples_dirs': '../walkthrough',   
     'gallery_dirs': 'auto-examples',  
     'filename_pattern': r'.+\.py',
}

autoapi_dirs = ["../bulletchess" ]          
autoapi_file_patterns = ["*.pyi"]

autoapi_options = [ 'members', 'undoc-members', 'private-members', 'show-inheritance', 'show-module-summary', 'special-members']

templates = ["_templates"]
add_module_names=False
autoapi_generate_api_docs = False
autoapi_member_order = "bysource"
toc_object_entries_show_parents = "hide"
toc_object_entries = True

# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
#html_theme = 'alabaster'
#html_theme = "sphinxawesome_theme"
html_theme = "pydata_sphinx_theme"
html_static_path = ['_static']

# from sphinxawesome_theme.postprocess import Icons
# html_permalinks_icon = Icons.permalinks_icon

