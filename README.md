# Q&A (Question & Answer) Extension For Quarto

This extension provides a very simple question and answer functionality for Quarto panels. This allows you to look at the question and answer side-by-side so that it's easier to maintain in-class practicals and similar working arrangements. For example, a sample workflow would be that students work on an iPython notebook in-class and see only the question so that they're not tempted to skip over to the answer. When you release the answers as a PDF then the students see only the answer. When you are working on updating your code for the year you can see the question and answer side-by-side. 

So the extension works by:

- Allowing you to specify a `.qna` panel in which the first panel is assumed to be the question and the second is assumed to be the answer.
- The first panel is included when the output is an iPython notebook.
- The second panel is included when the output is a PDF.
- Both panels are included when the output is HTML (to support `quarto preview`). 

## Installing

```bash
quarto add jreades/qna
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

So the basic format in a QMD will look something like this:

````markdown
:::: {.qna}

#### Question

How would you find the last element of this list in Python?

```python
l = range(1,10)
print(f"Last element is: {???}")
```

#### Answer

There are several ways to find the last element, but the most Pythonic way is:

```{python}
l = range(1,10)
print(f"Last element is: {l[-1]}")
```

::::

And your answer should produce:

```{python}
#| echo: false
#| output: asis
print(f"Last element is: {l[-1]}")
```
````

You can then:
- `quarto render <file>.qmd --to ipynb` to generate the question notebook (e.g. a practical).
- `quarto render <file>.qmd --to pdf` to generate the answer file.
- `quarto preview` to work on the question and answer simultaneously and checking your work.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).

