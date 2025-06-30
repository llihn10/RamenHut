const swiper = new Swiper('.slider-wrapper', {
  loop: true,
  grabCursor: true,
  spaceBetween: 30,

  pagination: {
    el: '.swiper-pagination',
    clickable: true,
    dynamicBullets: true
  },

  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  breakpoints: {
    0: {
      slidesPerView: 1
    },
    620: {
      slidesPerView: 2
    },
    1024: {
      slidesPerView: 3
    }
  }
});

// Login - Signup
function showForm(formType) {
  document.getElementById("login-form").classList.toggle("hidden", formType !== "login");
  document.getElementById("signup-form").classList.toggle("hidden", formType !== "signup");

  document.querySelectorAll(".tab-button").forEach(button => {
    button.classList.remove("active");
  });

  // Đánh dấu tab hiện tại
  document.querySelector(`[onclick="showForm('${formType}')"]`)?.classList.add("active");
}

function showForm(formType) {
    // Ẩn cả hai form
    document.getElementById("login-form").classList.add("hidden");
    document.getElementById("signup-form").classList.add("hidden");

    // Hiển thị form được chọn
    document.getElementById(`${formType}-form`).classList.remove("hidden");

    // Cập nhật trạng thái tab active
    document.querySelectorAll(".tab-button").forEach(button => button.classList.remove("active"));
    document.querySelector(`[onclick="showForm('${formType}')"]`).classList.add("active");

    // Cập nhật URL mà không reload trang
    const newUrl = window.location.pathname + `?tab=${formType}`;
    history.pushState({ path: newUrl }, "", newUrl);
}

// Khi tải trang, đọc URL để hiển thị đúng tab
document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const tab = urlParams.get("tab") || "login";
    showForm(tab);
});





