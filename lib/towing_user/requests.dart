import 'package:flutter/material.dart';
import 'package:quadro/towing_user/towing_car_map.dart';
class ServiceRequest {
  String userName;
  String contactNumber;
  String assistanceType;
  String? status;
   ServiceRequest({
    required this.userName,
    required this.contactNumber,
    required this.assistanceType,
     this.status,
   });
}

class ViewServiceRequestsPage extends StatefulWidget {
  const ViewServiceRequestsPage({super.key});

  @override
  _ViewServiceRequestsPageState createState() => _ViewServiceRequestsPageState();
}

class _ViewServiceRequestsPageState extends State<ViewServiceRequestsPage> {
  List<ServiceRequest> serviceRequests = [
    ServiceRequest(
      userName: 'Ahmed',
      contactNumber: '091-0097738',
      assistanceType: 'Flat Tire',
    ),
    ServiceRequest(
      userName: 'mohamed',
      contactNumber: '092-5713391',
      assistanceType: 'Battery Jump',
    ),
    // Add more sample service requests as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Service Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: serviceRequests.length,
          itemBuilder: (context, index) {
            ServiceRequest request = serviceRequests[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 10.0,
                child: ListTile(
                  title: Text('User: ${request.userName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact Number: ${request.contactNumber}',style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Assistance Type: ${request.assistanceType}',style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Status: ${request.status ?? 'Pending'}', style: TextStyle(fontWeight: FontWeight.bold, color: _getStatusColor(request.status))),

                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        color: Colors.green,
                        onPressed: () {
                          _handleAcceptAction(request);
                          // Handle accept action
                          // You can update the request status or perform other actions
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.red,
                        onPressed: () {
                          // Handle reject action
                          _handleRejectAction(request);
                          // You can update the request status or perform other actions
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.map),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RequestTowingMap()));

                            },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleAcceptAction(ServiceRequest request) {
    // Implement your logic for accepting the service request
    // For example, you can update the request status, notify the user, etc.

    // Update the status (this is just an example, you might have a more sophisticated way to manage status)
    request.status = 'Accepted';

    // Show a confirmation dialog or snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted service request from ${request.userName}'),
      ),
    );

    // Update the UI
    setState(() {});
  }

  void _handleRejectAction(ServiceRequest request) {
    // Implement your logic for rejecting the service request
    // For example, you can update the request status, notify the user, etc.

    // Update the status (this is just an example, you might have a more sophisticated way to manage status)
    request.status = 'Rejected';

    // Show a confirmation dialog or snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Rejected service request from ${request.userName}'),
      ),
    );

    // Update the UI
    setState(() {});
  }
  Color _getStatusColor(String? status) {
    if (status == 'Pending') {
      return Colors.orange;
    } else if (status == 'Accepted') {
      return Colors.green;
    } else if (status == 'Rejected') {
      return Colors.red;
    }
    return Colors.black;
  }


}
