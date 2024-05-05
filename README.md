### Overview
This is a minimal docker image for `pdftk-java`.

### Sample usage

```
# start the container
make run

# pick a few pages
pdftk \
  A=input.pdf \
  cat A51-54 \
  output \
  outfile.pdf

# create a pdf with pages from multiple input files
pdftk \
  A=doc1.pdf \
  B=doc2.pdf \
  cat A1-2 B1 A3-end \
  output outfile.pdf

# merge files
pdftk \
  input1.pdf input2.pdf input3.pdf \
  cat output \
  output.pdf
```

