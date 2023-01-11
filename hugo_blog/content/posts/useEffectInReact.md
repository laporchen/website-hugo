---
title: "useEffect() in React"
date: 2023-01-11T12:21:33+08:00
draft: false
toc: false
images:
tags:
  - react
---

Learning React recently. I'm currently developing a typing website, mainly focus on help learning new keyboard layout
(although I still didn't implement this feature.)

I was looking for methods to add event listener to react component. That's when I found out useEffect(). But I just use it the way I found out in someone's code snippet. I did not take a deep look into the details.

A few days ago. A senior took a look at my code and gave me some advices. That's when I actually learn more about this function hook.

There's a second optional variable in useEffect(), which is the dependencies of this hook. By default, if no dependencies was provided. This hook will run after anything updates in the component after initalized.

You can provided dependencies with a list. useEffect() will only run when the content in dependencies changes.

Here's an interesting part. If the list is empty. Then it will only run once when the component is created. Now this hook can act as an initalizer.

Now let's talk about a behavior combined with useState() that's confused me for a while.

Take a look at the code snippet down below.
```javascript
export default function App() {
	function foo() {
		console.log("mouseclick")
	}

	useEffect(() => {
		window.addEventListener("mousedown",foo)
		return () => {
			window.removeEventListener("mousedown",foo)
		}
	},[])
	return (
		<div></div>
	)
}
```
The useEffect will run once and add an event listener for mouse click.
Whenever the mouse is pressed, we'll see the "mouseclick" printed in the console.

But if we change the code to below
```javascript
export default function App() {
	const [counter,setCounter] = useState(0)

	function foo() {
		setCounter(counter + 1)
	}
	useEffect(() => {
		window.addEventListener("mousedown",foo)
		return () => {
			window.removeEventListener("mousedown",foo)
		}
	},[])
	return (
		<div>
			{counter}
		</div>
	)
}
```
You will notice that after the counter is added to 1. It won't update anymore.

After some test and reading the document. The reason that it won't update is that react only renders it once. But the **setCounter** in the foo is the old one. So when user clicks the mouse, the **old** foo is called. The setCounter in the **old** foo treats counter as the old one, thus it just update it from 0 to 1.

To fix this, we simply add **foo** as a dependency of the hook. Now when the counter is updated. The callback function will run and update the **old** foo to the new one.

For anyone interested in checking out more about useEffect. You can checkout out their [document](https://beta.reactjs.org/reference/react/useEffect#useeffect). 
