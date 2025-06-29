console.log(1)
console.log()


// Example usage:
const input = [1, 2, 3, 4]; // Replace with your input
const output = fft(input);
console.log('FFT Output:', output); // Display the FFT output

// Another simple example usage:
const input2 = [0, 1, 0, 1, 0, 1, 0, 1]; // A simple input for FFT
const output2 = fft(input2);
console.log('FFT Output (second example):', output2);

type Complex = [number, number];

/**
 * Computes the Fast Fourier Transform (FFT) of a given input array using the Cooley-Tukey algorithm.
 * This implementation handles complex numbers represented as `[real, imaginary]` tuples.
 * It recursively divides the input into even and odd parts.
 *
 * @param {Array<number | Complex>} input - The input array. Can contain numbers (real parts) or Complex tuples `[real, imaginary]`.
 * @returns {Array<Complex>} The FFT result as an array of Complex tuples `[real, imaginary]`.
 */
function fft(input: Array<number | Complex>): Array<Complex> {
  const n = input.length;

  // Convert input to an array of complex numbers [real, imaginary].
  // If the input elements are numbers, treat them as real parts with imaginary part 0.
  // If the input elements are already [number, number] tuples (from recursive calls), use them directly.
  const x = input.map(val => {
    if (typeof val === 'number') {
      return [val, 0];
    }
    // Assume it's already a complex number tuple [real, imag]
    return val;
  }) as Complex[];

  // Base case: if the array has only one element, return it as a complex number.
  if (n === 1) {
    return x;
  }

  // Ensure the input size is a power of 2 for the Cooley-Tukey algorithm.
  // For a robust implementation, input should be padded with zeros if not a power of 2.
  // For this example, we'll proceed but issue a warning if the size is not ideal.
  if ((n & (n - 1)) !== 0) {
    console.warn("FFT input size is not a power of 2. For accurate recursive FFT, input should be a power of 2.");
  }

  const even: Complex[] = [];
  const odd: Complex[] = [];

  // Divide the input array into even and odd indexed elements.
  for (let i = 0; i < n; i++) {
    if (i % 2 === 0) {
      even.push(x[i]);
    } else {
      odd.push(x[i]);
    }
  }

  // Recursively compute FFT for even and odd parts.
  const Y_even = fft(even);
  const Y_odd = fft(odd);

  const Y: Complex[] = new Array(n);

  // Combine the results using the twiddle factors.
  for (let k = 0; k < n / 2; k++) {
    const angle = -2 * Math.PI * k / n;
    const w_real = Math.cos(angle);
    const w_imag = Math.sin(angle);

    const odd_real = Y_odd[k][0];
    const odd_imag = Y_odd[k][1];

    // Complex multiplication: (w_real + i*w_imag) * (odd_real + i*odd_imag)
    // Formula: (ac - bd) + i(ad + bc)
    const term_real = w_real * odd_real - w_imag * odd_imag;
    const term_imag = w_real * odd_imag + w_imag * odd_real;

    // Y[k] = Y_even[k] + term
    Y[k] = [Y_even[k][0] + term_real, Y_even[k][1] + term_imag];
    // Y[k + n/2] = Y_even[k] - term
    Y[k + n / 2] = [Y_even[k][0] - term_real, Y_even[k][1] - term_imag];
  }

  return Y;
}


