window.togglePaymentOptions = function () {
  var paymentOptions = document.getElementById("payment_method_payment_type");
  var creditCardDiv = document.getElementById("credit_card_fields");
  if (paymentOptions.options[paymentOptions.selectedIndex].value == "credit_card") {
    creditCardDiv.style.display = 'block';
  } else {
    creditCardDiv.style.display = 'none';
  }
}
