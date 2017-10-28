# Markov Marketing Mix Attribution Model

Marketing Mix shiny app utlizing a combination of heuristic & probabilistic models.

![model](https://i.imgur.com/ZGqGEU8.png)

#### Heuristics
* fist touch
* last touch
* linear touch

#### Probabilistic
* makov model

Using Markov chains allow us to switch from heuristic models to probabilistic ones. We can represent every customer journey (sequence of channels/touchpoints) as a chain in a directed Markov graph where each vertex is a possible state (channel/touchpoint) and the edges represent the probability of transition between the states (including conversion.) By computing the model and estimating transition probabilities we can attribute every channel/touchpoint. [more](http://analyzecore.com/2016/08/03/attribution-model-r-part-1/)
