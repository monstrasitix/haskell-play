console.clear();


const base = 8;


const compose = (...fs) => (initial) => {
	return fs.reduce((v, f) => f(v), initial);
};


const composeAsync = (...fs) => (initial) => {
	return fs.reduce((v, f) => v.then(f), initial);
};


const test = (ff) => {
	window.document.write("<br />---------------------<br />");

	window.document.write([
  	ff(),
    ff(3),
    ff(3, 8),
    ff(4, 8, 3),
    ff(1, 3, 4, 3),
    ff(2, 3, 1, 3, 4),
  ].join("<br />"))
	
  window.document.write("<br />---------------------<br />");
};


const spacing1 = (...numbers) => {
	return numbers
  	.slice(0, 4)
    .map(x => `${x * base}px`)
    .join(" ")
};


const spacing2 = (...numbers) => {
	let output = "";
  let count = 0;
  
  while (numbers.length && count < 4) {
  	if (count > 0) {
    	output += " ";
    }
    
    output += `${numbers.shift() * base}px`;
  	count++;
  }
  
  return output;
};


const spacing3 = (...numbers) => {
	with (Array.prototype) {
  	return compose(
    	x => slice.call(x, 0, 4),
      x => map.call(x, x => `${x * base}px`),
      x => join.call(x, " "),
    )(numbers);
  }
};


const spacing4 = (...numbers) => {
	const length = numbers.length;
  let output = "";
  
	for (let index = 0; index < length && index < 4; index++) {
  	if (index > 0) {
    	output += " ";
    }
    
    output += `${numbers[index] * base}px`; 
  }
  
  return output;
};


const spacing5 = (...numbers) => {
	return numbers.slice(0, 4).reduce((line, num, index) => {
  	const value = `${num * base}px`;
    
    return index > 0
    	? `${line} ${value}`
      : `${line}${value}`;
  }, []);
};


const spacing6 = (...numbers) => {
  return numbers
  	.slice(0, 4)
    .join(" ")
    .replace(/(\d+)/g, (a) => `${a * base}px`);
};


test(spacing1);
test(spacing2);
test(spacing3);
test(spacing4);
test(spacing5);

test(spacing6);

