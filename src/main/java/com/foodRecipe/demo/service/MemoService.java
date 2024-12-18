package com.foodRecipe.demo.service;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.foodRecipe.demo.dao.MemoDao;
import com.foodRecipe.demo.dto.Memo;
@Service
public class MemoService {
	private MemoDao memoDao;
	
	public MemoService(MemoDao memoDao) {
		this.memoDao = memoDao;
	}
	public int insertMemo(String text, int RCP_SEQ, int STEP_NO, int memberId) {
		return memoDao.insertMemo(text, RCP_SEQ, STEP_NO, memberId);
		
	}
	public Memo findMemoBySTEP_NOAndRCP_SEQAndMemberId(int STEP_NO, int RCP_SEQ, int memberId) {
		return memoDao.findMemoBySTEP_NOAndRCP_SEQAndMemberId(STEP_NO, RCP_SEQ, memberId);
	}
	public int updateMemo(String text, int RCP_SEQ, int STEP_NO, int memberId) {
		return memoDao.updateMemo(text, RCP_SEQ, STEP_NO, memberId);
	}
	public void deleteMemo(Memo memo) {
		memoDao.deleteMemo(memo);		
	}
	
	public Map<Integer, List<Memo>> findMemoByMemberId(int memberId) {
        List<Memo> allMemos = memoDao.findMemoByMemberId(memberId);
        Map<Integer, List<Memo>> groupedMemos = new HashMap<>();
        for (Memo memo : allMemos) {
            groupedMemos
                .computeIfAbsent(memo.getRCP_SEQ(), k -> new ArrayList<>())
                .add(memo);
        }
        return groupedMemos;
    }
}