package com.qfedu.service;

import com.qfedu.vo.ResultVo;

import java.util.HashMap;
import java.util.List;

public interface RoleAuthorityService {
	//插入用户角色中间表
    ResultVo insert(List<HashMap<String, String>> list);
    
  //根据rid删除权限；权限修改时把某个角色的原权限全部删除重新添加
    int deleteByRid(Integer rid);
}
