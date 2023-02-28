import Swal from "sweetalert2"
import * as sweetalert2 from "sweetalert2"

window.addEventListener(('turbo:load'), () => {
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
    if (event.target && event.target.className === 'sign-out') {
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
            document.querySelector('.sign-out').submit()
          }
        })
        .catch(event.preventDefault())
    }

    if (event.target && event.target.className === 'delete') {
      event.preventDefault()
      Swal.fire({
        title: 'Are you sure?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.delete').submit()
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
