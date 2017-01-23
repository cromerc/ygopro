--レッド・ウルフ
function c511002716.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64379261,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511002716.spcon)
	e1:SetTarget(c511002716.sptg)
	e1:SetOperation(c511002716.spop)
	c:RegisterEffect(e1)
end
c511002716.collection={
	[58831685]=true;[10202894]=true;[65570596]=true;[511001464]=true;[511001094]=true;
	[68722455]=true;[58165765]=true;[45462639]=true;[511001095]=true;[511000365]=true;
	[14886469]=true;[30494314]=true;[81354330]=true;[86445415]=true;[100000562]=true;
	[34475451]=true;[40975574]=true;[37132349]=true;[61019812]=true;[19025379]=true;
	[76547525]=true;[55888045]=true;[97489701]=true;[67030233]=true;[65338781]=true;
	[45313993]=true;[8706701]=true;[21142671]=true;
}
function c511002716.cfilter(c)
	return c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c:IsSetCard(0x89b) or c511002716.collection[c:GetCode()]
end
function c511002716.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and c511002716.cfilter(eg:GetFirst())
end
function c511002716.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511002716.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(c:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0xfe0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
