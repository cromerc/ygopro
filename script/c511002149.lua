--Shark Splash
function c511002149.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511002149.condition)
	e1:SetTarget(c511002149.target)
	e1:SetOperation(c511002149.activate)
	c:RegisterEffect(e1)
end
c511002149.collection={
	[13429800]=true;[34290067]=true;[10532969]=true;[71923655]=true;[32393580]=true;
	[810000016]=true;[20358953]=true;[37798171]=true;[70101178]=true;[23536866]=true;
	[7500772]=true;[511001410]=true;[69155991]=true;[37792478]=true;[17201174]=true;
	[44223284]=true;[70655556]=true;[63193879]=true;[25484449]=true;[810000026]=true;
	[17643265]=true;[64319467]=true;[810000030]=true;[810000008]=true;[20838380]=true;
	[87047161]=true;[80727036]=true;[28593363]=true;[50449881]=true;[49221191]=true;
	[65676461]=true;[440556]=true;[511001273]=true;[31320433]=true;[5014629]=true;
	[14306092]=true;[84224627]=true;[511001163]=true;[511001169]=true;[511001858]=true;
}
function c511002149.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c511002149.collection[c:GetCode()] and c:IsType(TYPE_MONSTER) 
		and c:IsControler(tp) and c:GetPreviousControler()==tp
end
function c511002149.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511002149.cfilter,nil,tp)
	return g:GetCount()==1
end
function c511002149.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=eg:Filter(c511002149.cfilter,nil,tp):GetFirst()
	if chk==0 then return tc:IsCanBeEffectTarget(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tc:GetAttack()-1000)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c511002149.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-1000)
		tc:RegisterEffect(e1)
		local atk=tc:GetAttack()
		if atk<=0 then return end
		Duel.BreakEffect()
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
