/**
 * admin js
 * 
 * @package Marsesweb v2+
 * @author Marwin Silva
 */

// initialize API URLs
api['admin/delete']  = ajax_path+"admin/delete.php";
api['admin/dashboard']  = ajax_path+"admin/dashboard.php";
api['admin/system']  = ajax_path+"admin/system.php";


$(function() {

	// run DataTable
    $('.js_dataTable').DataTable({
        "aoColumnDefs": [ {'bSortable': false, 'aTargets': [ -1 ]} ]
    });


    // run metisMenu
    $(".js_metisMenu").metisMenu();


    // run open window
    $('body').on('click', '.js_open_window', function () {
        window.open(this.href, 'mywin', 'left=20,top=20,width=500,height=500,toolbar=1,resizable=0'); return false;
    });


    // run admin deleter
    $('body').on('click', '.js_admin-deleter', function () {
        var handle = $(this).attr('data-handle');
        var id = $(this).attr('data-id');
        var node = $(this).attr('data-node');
        confirm(__['Delete'], __['Are you sure you want to delete this?'], function() {
            $.post(api['admin/delete'], {'handle': handle, 'id': id, 'node': node}, function(response) {
                /* check the response */
                if(response.callback) {
                    eval(response.callback);
                } else {
                    window.location.reload();
                }
            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        });
    });

    // run dashboard
    if ( $('.dashboard-status').length ) {

        // Dashboard
        var userCounter = document.getElementById('dashboard-users').getContext('2d')
          , userCounterCache = {};

        function label_template( keys ){
            for ( var i in keys ){
                var date = (keys[i]).split('-');
                    date.shift();
                keys[i] = date.join('/');
            }
            return keys;
        }

        //JSON Values Finder
        function group_values( arr, key){
            var genre = [];
            for (var i in arr) {
                genre.push( arr[i][key] );
            }
            return genre;
        };

        (function dashboardUpdater() {
            $.get(api['admin/dashboard'], function(response) {
                
                if ( JSON.stringify( userCounterCache ) != JSON.stringify( response ) ) {
                    userCounterCache = response;

                    if(response.success) {

                        var dataUserCounter = response.data.userCounter;

                        Chart.defaults.global.multiTooltipTemplate = function(label){
                            return label.datasetLabel + ': ' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
                        };
                        
                        new Chart(userCounter).Line({
                            labels: label_template(Object.keys( dataUserCounter )),
                            datasets: [
                                {
                                    label: (__['Females'] ? __['Females'] : 'Female'),
                                    fillColor: "rgba(220,220,220,0.2)",
                                    strokeColor: "rgba(220,220,220,1)",
                                    pointColor: "rgba(220,220,220,1)",
                                    pointStrokeColor: "#fff",
                                    pointHighlightFill: "#fff",
                                    pointHighlightStroke: "rgba(220,220,220,1)",
                                    data: group_values( dataUserCounter, 'F' )
                                },
                                {
                                    label: (__['Males'] ? __['Males'] : 'Male'),
                                    fillColor: "rgba(151,187,205,0.2)",
                                    strokeColor: "rgba(151,187,205,1)",
                                    pointColor: "rgba(151,187,205,1)",
                                    pointStrokeColor: "#fff",
                                    pointHighlightFill: "#fff",
                                    pointHighlightStroke: "rgba(151,187,205,1)",
                                    data: group_values( dataUserCounter, 'M' )
                                }
                            ]
                        }, {
                            responsive: true,
                            bezierCurve: false,
                            scaleShowVerticalLines: false
                        });

                        var dataUserStatus = response.data.userStatus;

                        $('.dashboard-user-status-users').text( dataUserStatus.users );
                        $('.dashboard-user-status-males').text( dataUserStatus.males );
                        $('.dashboard-user-status-females').text( dataUserStatus.females );
                        $('.dashboard-user-status-not_activated').text( dataUserStatus.not_activated );
                        $('.dashboard-user-status-banned').text( dataUserStatus.banned );
                        $('.dashboard-user-status-online').text( dataUserStatus.online );
                        $('.dashboard-user-status-posts').text( dataUserStatus.posts );
                        $('.dashboard-user-status-conmments').text( dataUserStatus.conmments );
                        $('.dashboard-user-status-pages').text( dataUserStatus.pages );
                        $('.dashboard-user-status-groups').text( dataUserStatus.groups );
                        $('.dashboard-user-status-messages').text( dataUserStatus.messages );
                        $('.dashboard-user-status-notifications').text( dataUserStatus.notifications );

                    } else {
                        modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
                    }
                }

                setTimeout(dashboardUpdater, 3000);

            }, 'json')
            .fail(function() {
                modal('#modal-message', {title: __['Error'], message: __['There is some thing went worng!']});
            });
        })();
    }
});