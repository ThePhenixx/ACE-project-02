package controller;

import jakarta.ejb.EJB;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.TrackerFacade;
import sessions.VehiculetrackerFacade;

import java.io.IOException;
import java.util.List;

import entities.Tracker;
import entities.Vehicule;
import entities.Vehiculetracker;

/**
 * Servlet implementation class TrackerController
 */
public class TrackerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@EJB
    private TrackerFacade trackerFacade;
	
	@EJB
	private VehiculetrackerFacade vehiculetrackerFacade;
	
    public TrackerController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

        if ("getTrackers".equals(action)) {
            // Return trackers as JSON using javax.json
            List<Tracker> trackers = trackerFacade.findAll();

            // Build a JSON array
            JsonArrayBuilder arrayBuilder = Json.createArrayBuilder();
            for (Tracker tracker : trackers) {
            	
            	Boolean inUse = false;
            	List<Vehiculetracker> list = vehiculetrackerFacade.findAll();
            	for(Vehiculetracker vt: list) {
            		if(vt.getTracker1().getId() == tracker.getId() && vt.getDateFin()==null) {
            			inUse = true;
            		}
            	}
            	
                JsonObjectBuilder
                objectBuilder = Json.createObjectBuilder()
                    .add("id", tracker.getId())
                    .add("simNumber", tracker.getSimNumber())
                    .add("inUse", inUse);
                arrayBuilder.add(objectBuilder);
            }
            JsonArray jsonArray = arrayBuilder.build();

            // Convert JSON array to string
            String json = jsonArray.toString();

            response.setContentType("application/json");
            response.getWriter().write(json);
        } 
        
        else if ("deleteTracker".equals(action)) {
        	int id = Integer.parseInt(request.getParameter("id"));
            trackerFacade.remove(trackerFacade.find(id));
        } 
        
		else if(request.getParameter("simNumber") != ""){
			String simNumber = request.getParameter("simNumber");
			Tracker t = new Tracker();
			t.setSimNumber(simNumber);
			trackerFacade.create(t);
			response.sendRedirect("trackers.jsp");
		}
		else {
			response.sendRedirect("addTracker.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
