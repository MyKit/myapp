# Use the official Python image with Python 3.10.13
FROM python:3.10.13

# Set the working directory in the container
WORKDIR /app

# Install Graph Notebook and its prerequisites
RUN pip install graph-notebook

# Enable the visualization widget
RUN jupyter nbextension enable --py --sys-prefix graph_notebook.widgets

# Copy static html resources
RUN python -m graph_notebook.static_resources.install

# Copy premade starter notebooks
RUN python -m graph_notebook.notebooks.install --destination /notebooks

# Create nbconfig file and directory tree, if they do not already exist
RUN mkdir -p ~/.jupyter/nbconfig
RUN touch ~/.jupyter/nbconfig/notebook.json

# Expose the port for Graph Notebook
EXPOSE 8888

# Start Graph Notebook with a non-root user
CMD ["jupyter", "notebook", "--notebook-dir=/notebooks", "--ip='0.0.0.0'", "--port=8888", "--allow-root"]
