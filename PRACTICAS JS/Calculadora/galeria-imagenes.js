

let carouselContainer = document.querySelector('.carousel-container');
let images = document.querySelectorAll('.carousel img');
let prevButton = document.querySelector('.prev');
let nextButton = document.querySelector('.next');
let counter = 0;
let amount = images.length;

nextButton.addEventListener('click', nextImage);
prevButton.addEventListener('click', prevImage);

function nextImage() {
  counter++;
  if (counter > amount - 1) {
    counter = 0;
  }
  carouselContainer.style.transform = `translateX(-${counter * 100}%)`;
}

function prevImage() {
  counter--;
  if (counter < 0) {
    counter = amount - 1;
  }
  carouselContainer.style.transform = `translateX(-${counter * 100}%)`;
}
