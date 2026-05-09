# Perceptron in Pure Dart

## Background
The underlying idea of the perceptron originated in a 1943 paper by [Warren McCulloch and Walter Pitts](https://raw.githubusercontent.com/govwind/ML-Perceptron-Pure-Dart/main/McCulloch.and.Pitts.pdf), where they introduced the McCulloch-Pitts Neuron as a mathematical model of a biological neuron. It lacked learnable weights, a limitation addressed by [Frank Rosenblatt in 1958](https://raw.githubusercontent.com/govwind/ML-Perceptron-Pure-Dart/main/rosenblatt58.pdf), who introduced the modern perceptron. This was later extended in neural networks by replacing the step function with a differentiable activation function to support backpropagation.

---

## Writeup

A perceptron can linearly separate groups of points based on inputs.
Depending on the number of inputs, the decision boundary(boundary separating the two classes) takes the form of a line (2d), a plane (3d), or a hyperplane (>3d).

<img src="https://raw.githubusercontent.com/govwind/ML-Perceptron-Pure-Dart/main/graph.png" width="550" style="transform: rotate(-2deg);">

### Training a perceptron

Training is controlled by 2 **hyperparameters** (not to be confused with parameters such as weights and biases):

- **Learning rate (η):** controls the size of weight updates per step
- **Epochs:** how many times the model passes through the entire training dataset


### What happens in a single training pass?
<img src="https://raw.githubusercontent.com/govwind/ML-Perceptron-Pure-Dart/main/perceptron.png" width="550">

1. The perceptron computes a weighted sum of inputs plus a bias, then passes it through an activation function:

   > f(x) = act(w<sub>1</sub>x<sub>1</sub> + w<sub>2</sub>x<sub>2</sub> + ... + b)

   The **Heaviside step function** is used as the activation function.

2. The predicted output and the correct answer are compared. If a mismatch is found, each weight is adjusted using this formula:

   > w<sub>i</sub> += (target - predicted) * η * x<sub>i</sub>

3. Repeat these steps on the training data until an acceptable accuracy is reached.


---


## Perceptron Code

For simplicity, the code is kept in a single file and is reasonably small enough to read, understand, and replicate.

The code contains data for training a college admission predictor.

Uses 2 input features — high school grade and college entrance test score — to predict whether a
student will be admitted.

### Running the Example

Make sure to have the Dart compiler installed (available standalone or bundled with Flutter).

**Step 1 — Train the model and run inference:**
```dart
dart run main.dart
```
This will output the learned **weights and bias** after training, then prompt you to enter a grade and test score to run inference.


### Suggestions

- Adjust the learning rate carefully — too high and it will oscillate, too low and it will take forever to train.
- Try using other activation functions.
- Stochastic gradient descent can be used for training instead of batch learning.
