Travelling salesperson problem
==============================

Did not really understood the `Travelling salesperson problem` myself ^^ , but on the wikipedia [page](https://en.wikipedia.org/wiki/Travelling_salesman_problem) they were saying that algorithms could easily and quickly manage to find the solution which made me motivated to try the challenge on what I did understood of the problem.
Doubtless, this is not the best program to find the solution. Also, did not made a huge amount of tests.

Here an example of usage:

```
    ./tsp.rb 3:0 5:2 0:2 5:8
```

Process:

- Collect the given points.
- Make pairs of every possible two points connection.
- Sort them by the distance between them.
- Connect the points when none of the pair's component are involved in other connection (part which problably needs more tests).
- Output the list.
