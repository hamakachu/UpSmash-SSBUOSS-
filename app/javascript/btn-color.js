const colorChange = () => {
const btnElements = document.querySelectorAll('.btn');

btnElements.forEach(btn => {
  btn.addEventListener('mouseenter', () => {
    btn.style.color = '#ffffff';
    btn.style.borderColor = '#00bfff';
    btn.style.backgroundColor = '#00bfff';
  });

  btn.addEventListener('mouseleave', () => {
    btn.style.color = '';
    btn.style.borderColor = '';
    btn.style.backgroundColor = '';
  });
});
}
window.addEventListener("load", colorChange)