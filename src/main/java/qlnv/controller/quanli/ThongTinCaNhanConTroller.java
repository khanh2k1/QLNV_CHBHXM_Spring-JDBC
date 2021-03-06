//package qlnv.controller.admin;
//
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import qlnv.custom.NhanVien;
//import qlnv.dao.NhanVienDAO;
//import qlnv.entity.NHANVIEN;
//
//import java.sql.SQLException;
//import java.time.LocalDate;
//import java.time.temporal.ChronoUnit;
//
//@Controller
//@RequestMapping("/NhanVienQuanLi/")
//public class ThongTinCaNhanConTroller {
//
//    // form edit thong tin nhan vien
//    @RequestMapping(value = "ThongTinCaNhan/{maNV}", method = RequestMethod.GET)
//    public String formEditThongTinCaNhan(@PathVariable(value = "maNV") String maNV,
//                                   Model model,
//                                   String tenLoaiNhanVien) throws SQLException {
//        // dua thong tin nhan vien vao form
//        NHANVIEN nv = NhanVienDAO.getNhanVienByID(maNV);
//        model.addAttribute("tenLoaiNV", NhanVien.getTenLoaiNhanVien(nv.getLoaiNV()));
//        model.addAttribute("nhanVien", nv);
//        // tra ve .jsp
//        return "admin/ThongTinNhanVien";
//    }
//
//    // edit nhan vien
//    @RequestMapping(value = "editNhanVien/{maNV}", method = RequestMethod.POST)
//    public String editThongTinCaNhan(@PathVariable("maNV") String maNV,
//                               @ModelAttribute(value = "nhanVien") NHANVIEN nv,
//                               Model model) throws SQLException {
//
//        // lay tuoi cua nhan vien
//        LocalDate test_end = LocalDate.now();
//        LocalDate test_start = nv.getNgaysinh().toLocalDate();
//        long years = ChronoUnit.YEARS.between(test_start, test_end);
//        //System.out.println(years); // 17
//
//        // lay ten loai nhan vien
//        model.addAttribute("tenLoaiNV",NhanVien.getTenLoaiNhanVien(nv.getLoaiNV()));
//
//        // regex
//        boolean check = true;
//        String phoneNumber_regex="0[0-9]{9}";
//        String email_regex="^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}";
//        String basic_salary_regex = "[1-9]{1}[0-9]{3,7}";
//        // ====validate=====
//        // ten nhan vien
//
//        if (nv.getHoten().isEmpty()) {
//            check=false;
//            model.addAttribute("message_hoten", "T??n nh??n vi??n kh??ng ???????c ????? tr???ng !");
//        }
//        if (nv.getHoten().length() < 2 || nv.getHoten().length() > 100) {
//            check=false;
//            model.addAttribute("message_hoten", "H??? t??n nh??n vi??n t??? 2 k?? t??? v?? b?? h??n 100 k?? t??? !");
//        }
//        // dia chi
//        if (nv.getDiachi().isEmpty()) {
//            check=false;
//            model.addAttribute("message_diachi", "?????a ch??? kh??ng ???????c ????? tr???ng !");
//        }
//        // sdt
//        if(nv.getSdt().isEmpty()){
//            check=false;
//            model.addAttribute("message_sdt", "S??? ??i???n tho???i kh??ng ???????c ????? tr???ng !");
//        }
//        if(nv.getSdt().matches(phoneNumber_regex)==false){
//            check=false;
//            model.addAttribute("message_sdt","Nh???p sai ?????nh dang s??? ??i???n tho???i ( ch??? c?? 10 s??? t??? 1 ?????n 9 ) !");
//        }
//        if(nv.getEmail().isEmpty()){
//            check=false;
//            model.addAttribute("message_email","Email kh??ng ???????c b??? tr???ng !");
//        }
//        if(nv.getEmail().matches(email_regex)==false){
//            check=false;
//            model.addAttribute("message_email","Sai ?????nh d???ng email !");
//        }
//        if(years < 18){
//            check=false;
//            model.addAttribute("message_age","Nh??n vi??n ch??a ????? 18 ????? l??m vi???c !");
//        }
//        if(years > 40){
//            check=false;
//            model.addAttribute("message_age","Nh??n vi??n qu?? tu???i lao ?????ng ( l???n h??n 40 ) !");
//        }
//        // luongcoban
//        if(nv.getLuongcoban().isEmpty()){
//            check=false;
//            model.addAttribute("message_luongcoban","L????ng kh??ng th??? r???ng !");
//        }
//        if(nv.getLuongcoban().matches(basic_salary_regex)==false){
//            check=false;
//            model.addAttribute("message_luongcoban","L????ng ph???i l???n h??n 1000 v?? b?? h??n 99.999.999 !");
//        }
//        // thanh cong
//        if(check==false) return "admin/ThongTinNhanVien";
//        else NhanVienDAO.update(nv);
//
//        return "redirect:/NhanVienQuanLi/DanhSachNhanVien";
//    }
//}
