<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/hiring-new.css" />
    <style>
        .left-panel > ul > li:nth-child(2) > a, .left-panel > ul > li:nth-child(2) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(2) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
  </head>
  <body>
    <div class="left-panel-include"></div>
    <div class="user-panel-include"></div>

    <div class="right-section">
        <h1>New Process</h1>
        <div class="container-1100">
            <div class="filters">
                <div class="filter">
                    <input type="text" placeholder="Access Key" />
                    <button class="gray-btn">Search</button>
                </div>
                <div class="filter">
                    Generate Access Key
                    <select>
                        <option data-value="- Select -">- Select -</option>
                        <option data-value="1">1</option>
                        <option data-value="2">2</option>
                        <option data-value="3">3</option>
                        <option data-value="4">4</option>
                        <option data-value="5">5</option>
                        <option data-value="6">6</option>
                        <option data-value="7">7</option>
                        <option data-value="8">8</option>
                        <option data-value="9">9</option>
                        <option data-value="10">10</option>
                    </select>
                    <button class="gray-btn">Generate</button>
                </div>
            </div>

            <div class="table-date">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="data">
                    <thead>
                        <tr>
                            <th data-head="S. No."><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Name"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Emai ID"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Mobile Number"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Designation"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Access Key"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Date of Application"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th><span><em>Send Communication</em></span></th>
                            <th data-head="Started"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>John Doe</td>
                            <td>johndoe@gmail.com</td>
                            <td>9876543212</td>
                            <td>Sales</td>
                            <td>SD3244</td>
                            <td>1st May 2022</td>
                            <td><span class="mail-a-key"><img src="./img/mail-icn.svg" /></span></td>
                            <td>Not Started</td>
                            <td><a href="#"><img src="./img/delete-icn.svg" /></a></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Sam Mathur</td>
                            <td>sam.mathur32@radiff.com</td>
                            <td>9876543212</td>
                            <td>Sales</td>
                            <td>CCSXSD</td>
                            <td>1st May 2022</td>
                            <td><span class="mail-a-key active"><img src="./img/mail-icn.svg" /></span></td>
                            <td>Started</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Vaibhav Kulkarni</td>
                            <td>vai_kul_imrex@yahoo.com</td>
                            <td>9876543212</td>
                            <td>Sales</td>
                            <td>MCE344</td>
                            <td>1st May 2022</td>
                            <td><span class="mail-a-key"><img src="./img/mail-icn.svg" /></span></td>
                            <td>Not Started</td>
                            <td><a href="#"><img src="./img/delete-icn.svg" /></a></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Sagar Bansal</td>
                            <td>sagar.bansal@gmail.com</td>
                            <td>9876543212</td>
                            <td>Sales</td>
                            <td>XC3RSD</td>
                            <td>1st May 2022</td>
                            <td><span class="mail-a-key"><img src="./img/mail-icn.svg" /></span></td>
                            <td>Started</td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="communications-popup">
        <h3>Communications</h3>
        <form class="form-section" action="">
            <div class="form-block">
                <input type="text" placeholder="First Name" />
            </div>
            <div class="form-block">
                <input type="text" placeholder="Middle Name" />
            </div>
            <div class="form-block">
                <input type="text" placeholder="Last Name" />
            </div>
            <div class="form-block">
                <input type="email" placeholder="Email ID" />
            </div>
            <div class="form-block">
                <input type="number" placeholder="Mobile Number" />
            </div>
            <div class="form-block">
                <select>
                    <option>Select Designation</option>
                    <option>Designation 1</option>
                    <option>Designation 2</option>
                    <option>Designation 3</option>
                </select>
            </div>
            <div class="form-button">
                <button class="cancel-btn">Cancel</button>
                <button class="submit-btn">Submit</button>
            </div>
        </form>
    </div>

    <div class="key-popup">
        <p>The candidate has already been part of recruitment process. His previous access key was:</p>
        <h2>WER3FSV</h2>
        <div class="form-button">
            <button class="submit-btn">Yes</button>
            <button class="cancel-btn outline-btn">No</button>
        </div>
    </div>

    <div class="blk-bg"></div>
    <script>
      $(document).ready(function () {
        $(".left-panel-include").load("/includes/left-panel/left-panel.html");
        $(".user-panel-include").load("/includes/user-panel/user-panel.html");

        var table = $('#data').DataTable({
                "orderCellsTop": true,
                "responsive": true,
                autoWidth: false
            });

            $('#data thead tr')
                .clone(true)
                .find('th')
                .removeClass('sorting_asc sorting_asc sorting')
                .off('click')
                .end()
                .appendTo('#data thead');

            $('#data thead tr:eq(1) th').each(function (i) {
                var title = $(this).data('head');
                if(title){
                    $(this).html('<input type="text" placeholder="' + title + '" />');
                } else{
                    $(this).html('');
                }

                $('input', this).on('keyup change', function () {
                    if (table.column(i).search() !== this.value) {
                        table
                            .column(i)
                            .search(this.value)
                            .draw();
                    }
                });
            });

            $('.mail-a-key').on('click', function(){
                $('.communications-popup, .blk-bg').show();
            });
            $('.cancel-btn').on('click', function(){
                $('.communications-popup, .blk-bg, .key-popup').hide();
                return false;
            });
            $('.communications-popup .submit-btn').on('click', function(){
                $('.communications-popup').hide();
                $('.key-popup').show();
                return false;
            });
            $('.key-popup .submit-btn').on('click', function(){
                $('.key-popup, .blk-bg').hide();
                return false;
            });
      });
    </script>
  </body>
</html>
