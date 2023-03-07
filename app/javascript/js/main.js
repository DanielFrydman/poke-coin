import Swal from "sweetalert2"
import * as sweetalert2 from "sweetalert2"

window.addEventListener(('turbo:load'), () => {
  let chart2 = document.getElementById('chart-2')
  if (chart2 != undefined) {
    chart2.style.margin = 'auto';
    chart2.style.width = '50%';
  }

  let flashNotice = document.getElementsByClassName('flash-notice')[0];
  let flasAlert = document.getElementsByClassName('flash-alert')[0];
  if (flashNotice != undefined) {
    Swal.fire({
      position: 'top-end',
      icon: 'success',
      title: `${flashNotice.innerHTML}`,
      showConfirmButton: false,
      timer: 1500
    })
  }
  if (flasAlert != undefined ) {
    Swal.fire({
      position: 'top-end',
      icon: 'error',
      title: `${flasAlert.innerHTML}`,
      showConfirmButton: false,
      timer: 1500
    })
  }
  document.addEventListener('submit', (event) => {
    if (event.target && event.target.className === 'are-you-sure') {
      event.preventDefault()
      Swal.fire({
        title: 'Are you sure?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.are-you-sure').submit()
          }
        })
        .catch(event.preventDefault())
    }

    if (event.target && event.target.className === 'delete-sell') {
      event.preventDefault()
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, sell it!'
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.delete-sell').submit()
          }
        })
        .catch(event.preventDefault())
    }

    if (event.target && event.target.className === 'delete-account') {
      event.preventDefault()
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, cancel it!'
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.delete-account').submit()
          }
        })
        .catch(event.preventDefault())
    }

    if (event.target && event.target.className === 'success') {
      event.preventDefault()
      Swal.fire(
        'Good job!',
        'You clicked the button!',
        'success'
      )
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.success').submit()
          }
        })
        .catch(event.preventDefault())
    }
  })
})
