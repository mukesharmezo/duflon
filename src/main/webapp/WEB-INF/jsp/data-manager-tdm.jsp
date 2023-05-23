<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.armezo.duflon.Entities.ParticipantRegistration"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "java.util.ResourceBundle" %>
<%
try
    {
	ResourceBundle resource = ResourceBundle.getBundle("application");
String baseServer = resource.getString("client.url");String title = resource.getString("app.title");
	%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="<%=baseServer%>img/DuflonFavicon.png"/>
    <title><%=title %></title>
    <link rel="stylesheet" type="text/css" href="./css/common.css" />
    <link rel="stylesheet" type="text/css" href="./css/data-manager-tdm.css" />
    <style>
        .left-panel > ul > li:nth-child(4) > a, .left-panel > ul > li:nth-child(4) > ul > li:nth-child(1) > a{opacity: 1;}
        .left-panel > ul > li:nth-child(4) > ul > li:nth-child(1) > a::after{content: ''; position: absolute; right: 0; top: 50%; transform: translate(0, -50%); border-right: 6px solid #fff; border-top: 6px solid transparent; border-bottom: 6px solid transparent;}
    </style>

    <script src="./js/jquery-3.4.1.min.js"></script>
    <script src="./js/jquery.dataTables.min.js"></script>
  </head>
  <body>
    <div class="left-panel-include"></div>
    <div class="user-panel-include"></div>

    <div class="right-section">
        <h1>Data Manager - TDM</h1>
        <div class="container-1100">
            <div class="filters">
                <div class="filter">
                    <button class="gray-btn search-tdm">Search</button>
                </div>
                <div class="filter">
                    <button class="gray-btn edit-tdm">EDIT Mapping</button>
                </div>
                <div class="export-tdm outline-btn-export">Export to CSV</div>
            </div>

            <div class="table-date">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="data">
                    <thead>
                        <tr>
                            <th data-head="S. No."><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Region"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="State"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="City"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Parent Dealer"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Outlet"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Outlet Code"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Dealer Name"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Dealer Email ID"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="Dealer Mobile No"><span><img src="./img/filter-icn.svg" /></span></th>
                            <th data-head="MSPIN"><span><img src="./img/filter-icn.svg" /></span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>C1</td>
                            <td>DELHI</td>
                            <td>DELHI</td>
                            <td>BAGGA</td>
                            <td>BAGGA LINK MOTORS LTD</td>
                            <td>0811-08</td>
                            <td>Alok Nath</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>C1</td>
                            <td>DELHI</td>
                            <td>DELHI</td>
                            <td>BAGGA</td>
                            <td>BAGGA LINK MOTORS LTD</td>
                            <td>0811-08</td>
                            <td>Alok Nath</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>C1</td>
                            <td>DELHI</td>
                            <td>DELHI</td>
                            <td>BAGGA</td>
                            <td>BAGGA LINK MOTORS LTD</td>
                            <td>0811-08</td>
                            <td>Alok Nath</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>C1</td>
                            <td>DELHI</td>
                            <td>DELHI</td>
                            <td>BAGGA</td>
                            <td>BAGGA LINK MOTORS LTD</td>
                            <td>0811-08</td>
                            <td>Alok Nath</td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="search-popup tdm-popup">
        <h2>Search TDM</h2>
        <div class="popup-form">
            <div class="form-section">
                <div class="form-block">
                    <input type="text" placeholder="Dealer Name" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="Parent Dealer" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="Outlet Name" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="MSPIN" />
                </div>
            </div>
        </div>
        <div class="form-button">
            <button class="submit-btn">Search</button>
            <button class="cancel-btn outline-btn">Reset</button>
        </div>
    </div>

    <div class="edit-popup tdm-popup">
        <h2>Edit Mapping</h2>
        <div class="popup-form">
            <div class="form-section">
                <div class="form-block full-width">
                    <input type="text" placeholder="Search Dealer Name" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="MSPIN" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="Dealer name" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="Dealer Email ID" />
                </div>
                <div class="form-block">
                    <input type="text" placeholder="Dealer Mobile Number" />
                </div>
                <div class="form-block full-width">
                    <select>
                        <option>Select Mapped Outlets</option>
                        <option>Outlet 1</option>
                        <option>Outlet 2</option>
                        <option>Outlet 3</option>
                        <option>Outlet 4</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="form-button">
            <button class="submit-btn">Submit</button>
        </div>
        <div class="add-dealer">
            <a href="./data-manager-tdm.html" class="btn">Add Dealer</a>
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
            $('.search-tdm').on('click', function(){
                $('.search-popup, .blk-bg').show();
                return false;
            });
            $('.edit-tdm').on('click', function(){
                $('.edit-popup, .blk-bg').show();
                return false;
            });
            $('.submit-btn, .cancel-btn').on('click', function(){
                $('.search-popup, .blk-bg, .edit-popup').hide();
                return false;
            });
      });
    </script>
  </body>
</html>
<%
 }catch(Exception e)
    {
    	 System.out.println("Errror....."+e);
    	  response.sendRedirect("login");
    }%>
