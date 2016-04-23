--クリアー・ヴィシャス・ナイト
function c100000163.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_REMOVE_ATTRIBUTE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100000163.ratg)
	e1:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e1)	
	--summon with 1 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000163,0))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c100000163.otcon)
	e2:SetOperation(c100000163.otop)
	e2:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000163.adcon)
	e3:SetValue(c100000163.adval)
	c:RegisterEffect(e3)
end
function c100000163.ratg(e)
	return e:GetHandler()
end
function c100000163.otcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>6 and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)~=0 and Duel.GetTributeCount(c)>0
end
function c100000163.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetTributeGroup(c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:Select(tp,1,1,nil)
	c:SetMaterial(sg)
	Duel.Release(sg, REASON_SUMMON+REASON_MATERIAL)
end
function c100000163.filter(c)
	return not c:IsStatus(STATUS_LEAVE_CONFIRMED)
end
function c100000163.adcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100000163.filter,e:GetHandler():GetControler(),LOCATION_ONFIELD+LOCATION_HAND,0,1,e:GetHandler())
end
function c100000163.adval(e,c)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,e:GetHandler():GetControler(),0,LOCATION_MZONE,e:GetHandler())
	if g:GetCount()==0 then 
		return 0
	else
		local tg,val=g:GetMaxGroup(Card.GetBaseAttack)
		return val
	end
end