package com.Group1.CoinShell.controller.Hoxton;

import java.io.IOException;
import java.util.Base64;
import java.util.Optional;

import javax.annotation.PostConstruct;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.Group1.CoinShell.model.Hoxton.Cart;
import com.Group1.CoinShell.model.Hoxton.Commodity;
import com.Group1.CoinShell.model.Hoxton.CommodityDao;
import com.Group1.CoinShell.service.Hoxton.CommodityService;

@Controller
public class CommodityController {
	
	@Autowired
	private CommodityService service;
	@Autowired
	private CommodityDao dao;
	
	//返回首頁
	@PostMapping("administrator/store/commodityUpload")
	public String addNewCommodity(
			@RequestParam("name")String name,
			@RequestParam("describe")String describe,
			@RequestParam("volume") Integer volume,
			@RequestParam("photo")MultipartFile file,
			@RequestParam("shellOrCoin")String shellOrCoin,
			@RequestParam("myShell") Integer myShell,
			@RequestParam("coin")Integer coin) {
		Commodity commodity = new Commodity();
		commodity.setCommodityName(name);
		commodity.setDescribe(describe);
		commodity.setVolume(volume);
		try {
			byte[] bytes = file.getBytes();
			commodity.setPhoto(bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}
		commodity.setShellOrCoin(shellOrCoin);
		commodity.setMyShell(myShell);
		commodity.setCoin(coin);
		dao.save(commodity);
	
	return "redirect:/administrator/store";	
	}
	
	@GetMapping("administrator/store/editCommodity")
	public ModelAndView changePageToEditCommodity(@RequestParam("id")Integer id) {
		Commodity commodity = service.findCommodityById(id);
		return new ModelAndView("backend/store/editCommodity","commodity",commodity);
	}
	
	@PostMapping("administrator/store/editCommodity")
	public String editCommodity
	(@RequestParam("id") Integer id, 
			@RequestParam("name")String name,
			@RequestParam("describe")String describe,
			@RequestParam("volume")String volume,
			@RequestParam("shellOrCoin") String shellOrCoin,
			@RequestParam("myShell") Integer myShell,
			@RequestParam("coin")Integer coin) {
		service.updateCommodityById(name, describe, shellOrCoin, myShell, coin, coin, id);
		return "redirect:/administrator/store";
	}
	
	@GetMapping("administrator/store/deleteCommodity")
	public String deleteCommodity(@RequestParam("id")Integer id) {
		service.deleteCommodityById(id);
		return "redirect:/administrator/store";
	}
	
	@GetMapping("administrator/store/search")
	public String findCommodityByName(@RequestParam("name")String name) {
		return "backend/store/ShowParticularCommodities";
	}
	
	@PostMapping("addCart")
	public String addCart(HttpSession session, 
			@RequestParam("id")Integer id,
			@RequestParam("myShell")Integer myShell) {
		session.setMaxInactiveInterval(600);
		Cart cart=(Cart)session.getAttribute("cart");
		if(cart==null) {
			cart=new Cart();
			session.setAttribute("cart", cart);
		}
		service.buyCommodity(id, cart);
		return "/store/store";
	}
	
	@GetMapping("deleteCart")
	public String deleteCart(HttpSession session, @RequestParam("id")Integer id) {
		Cart cart =(Cart)session.getAttribute("cart");
		service.deleteCommodity(id, cart);
		return "/store/cart";
	}
	
	@PostMapping("goCart")
	public String goCart() {
		return "/store/cart";
	}
	
//	@PostMapping("addCart")
//	public String addCart(HttpServletRequest request) {
//		Cookie[] cookies = request.getCookies();
//		Cookie cart_cookie= null;
//		if(cookies!=null) {
//			for(Cookie cookie : cookies){
//				if("cart".equals(cookie.getName())) {
//					cart_cookie=cookie;
//				}
//			}
//		}
//		
//	}
	


}
