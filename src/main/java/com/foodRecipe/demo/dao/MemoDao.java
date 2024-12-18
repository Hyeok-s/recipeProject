package com.foodRecipe.demo.dao;
import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.foodRecipe.demo.dto.Memo;
@Mapper
public interface MemoDao {
	@Insert("INSERT INTO memo(text, RCP_SEQ, STEP_NO, memberID) VALUE(#{text}, #{RCP_SEQ}, #{STEP_NO}, #{memberId})")
	int insertMemo(String text, int RCP_SEQ, int STEP_NO, int memberId);
	
	@Select("SELECT * FROM memo WHERE STEP_NO = #{STEP_NO} AND RCP_SEQ = #{RCP_SEQ} AND memberId = #{memberId}")
	Memo findMemoBySTEP_NOAndRCP_SEQAndMemberId(int STEP_NO, int RCP_SEQ, int memberId);
	
	@Update("UPDATE memo SET text = #{text} WHERE STEP_NO = #{STEP_NO} AND RCP_SEQ = #{RCP_SEQ} AND memberId = #{memberId}")
	int updateMemo(String text, int RCP_SEQ, int STEP_NO, int memberId);
	
	@Delete("DELETE FROM memo WHERE id = #{id}")
	void deleteMemo(Memo memo);
	
	@Select("""
			SELECT m.*, i.RCP_NM FROM memo m INNER JOIN recipe_info i 
			ON m.RCP_SEQ = i.RCP_SEQ WHERE m.memberId = #{memberId} 
			ORDER BY m.RCP_SEQ, m.STEP_NO
			""")
	List<Memo> findMemoByMemberId(int memberId);
}