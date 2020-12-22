window.addEventListener('load', () => {

  const priceInput = document.getElementById("item-price");
  const feeInput = document.getElementById("add-tax-price");
  const profitInput = document.getElementById("profit");

priceInput.addEventListener("input", () => {
  const priceValue = priceInput.value;
  feeInput.innerHTML = (Math.floor(priceValue * 0.1));
  const feeValue = feeInput.textContent;
  profitInput.innerHTML = (Math.floor(priceValue - feeValue));
  })
})
